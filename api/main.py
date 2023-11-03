import requests
from bs4 import BeautifulSoup
import time
from datetime import datetime, timedelta


def scrape_events():
    events = []
    for i in range(30):
        date = datetime.now() + timedelta(days=i)
        date_str = date.strftime("%Y-%m-%d")
        url = f"https://imprezy.trojmiasto.pl/kalendarz-imprez/dzien,{date_str},offset,120.html"
        response = requests.get(url)
        soup = BeautifulSoup(response.content, "html.parser")
        
        for event in soup.find_all("div", class_="event__item"):
            title = event.find("a", class_="event__item__title").text.strip()
            try:
                month = event.find("span", class_="calendar-icon__icon__month").text.strip()
                day = event.find("span", class_="calendar-icon__icon__day").text.strip()
            except:
                month = "None"
                day = event.find("p", class_="event__item__date").text.strip()
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
            image = event.find("img", itemprop="image")['src']
            if image == "https://s-trojmiasto.pl/_img/1px_transparent.png":
                image = "None"
            link = event.find("a", class_="event__item__title")['href']
            try: category = event.find("a", class_="event__item__types__link").text.strip()
            except: category = "None"
            
            city = event.find("span", class_="event__item__location__city").text.strip()
            try: localization = event.find("a", class_="event__item__location__place").text.strip()
            except: localization = "None"
            event_data = {
                "title": title,
                "month": month,
                "day": day,
                "image": image,
                "link": link,
                "category": category,
                "city": city,
                "localization": localization
            }
            print('Scraped event: ', title)
            if event_data not in events:
                events.append(event_data)
    return events

events = scrape_events()
print(events)
print('Scraped events: ', len(events))