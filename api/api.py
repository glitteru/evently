from flask import Flask, jsonify, request
import requests
from bs4 import BeautifulSoup
import time
from datetime import datetime, timedelta
import logging
import os
from apscheduler.schedulers.background import BackgroundScheduler
from waitress import serve
from flask_cors import CORS

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)
scheduler = BackgroundScheduler()


def scrape_events():
    events = []
    for i in range(30):
        date = datetime.now() + timedelta(days=i)
        date_str = date.strftime("%Y-%m-%d")
        url = f"https://imprezy.trojmiasto.pl/kalendarz-imprez/dzien,{date_str},offset,120.html"
        try:
            response = requests.get(url)
            response.raise_for_status()
        except requests.HTTPError as http_err:
            logging.error(f'HTTP error occurred: {http_err}')
            continue
        except Exception as err:
            logging.error(f'Other error occurred: {err}')
            continue

        soup = BeautifulSoup(response.content, "html.parser")
        
        for event in soup.find_all("div", class_="event__item"):
            title = event.find("a", class_="event__item__title").text.strip()
            try:
                month = event.find("span", class_="calendar-icon__icon__month").text.strip()
                day = event.find("span", class_="calendar-icon__icon__day").text.strip()
            except:
                month = "None"
                day = "None"
            if month == "sty":
                month = "01"
            elif month == "lut":
                month = "02"
            elif month == "mar":
                month = "03"
            elif month == "kwi":
                month = "04"
            elif month == "maj":
                month = "05"
            elif month == "cze":
                month = "06"
            elif month == "lip":
                month = "07"
            elif month == "sie":
                month = "08"
            elif month == "wrz":
                month = "09"
            elif month == "paź":
                month = "10"
            elif month == "lis":
                month = "11"
            elif month == "gru":
                month = "12"
            image = event.find("img", class_="img_bg")['src']
            if image == "https://s-trojmiasto.pl/_img/1px_transparent.png":
                image = "None"
            link = event.find("a", class_="event__item__title")['href']
            try: category = event.find("a", class_="event__item__types__link").text.strip()
            except: category = "None"
            if month == "01" and date.strftime("%m") == "12":
                year = str(datetime.now().year + 1)
            else:
                year = str(datetime.now().year)
            day = str(day).zfill(2)
            month = str(month).zfill(2)
            city = event.find("span", class_="event__item__location__city").text.strip()
            try: localization = event.find("a", class_="event__item__location__place").text.strip()
            except: localization = "None"
            if day != "None":
                response = requests.get(link)
                soup = BeautifulSoup(response.text, 'html.parser')
                if image == "None":
                    image_div = soup.find("div", class_="thumb-content")
                    if image_div:
                        image = image_div.find("img")["src"]
                    elif soup.find("img", class_="SpectacleInfo__img"):
                        image = soup.find("img", class_="SpectacleInfo__img")["src"]
                description_div = soup.find("div", class_="text-contents")
                if description_div:
                    description = description_div.get_text().strip()
                if '-' in day:
                    days = day.split('-')
                    for d in days:
                        if d.isdigit() and len(d) <= 2:
                            d = str(d).zfill(2)
                            event_data = {
                                "title": title,
                                "image": image,
                                "link": link,
                                "category": category,
                                "city": city,
                                "localization": localization,
                                "date": f"{year}-{month}-{d}",
                                "description": description
                            }
                            if event_data not in events:
                                events.append(event_data)
                                print('Scraped event: ', title)
                else:
                    event_data = {
                        "title": title,
                        "image": image,
                        "link": link,
                        "category": category,
                        "city": city,
                        "localization": localization,
                        "date": date,
                        "description": description
                    }
                    if event_data not in events:
                        events.append(event_data)
                        print('Scraped event: ', title)
    return events


def reset_events():
    global events
    events = scrape_events()

scheduler.add_job(reset_events, 'cron', hour=4)
scheduler.start()

def create_app():
    app = Flask(__name__)
    CORS(app) 

    @app.route('/api/events', methods=['GET'])
    def get_events():
        return jsonify(events)

    reset_events()

    return app

app = create_app()

if __name__ == '__main__':
    serve(app, host='0.0.0.0', port=int(os.environ.get("PORT", 8000)))