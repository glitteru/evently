import unittest
from api import scrape_events

class TestScrapeEvents(unittest.TestCase):
    def setUp(self):
        self.events = scrape_events()

    def test_returns_list(self):
        self.assertIsInstance(self.events, list)

    def test_returns_list_of_dicts(self):
        for event in self.events:
            self.assertIsInstance(event, dict)

    def test_returns_correct_keys(self):
        for event in self.events:
            self.assertIn('title', event)
            self.assertIn('month', event)
            self.assertIn('day', event)
            self.assertIn('image', event)
            self.assertIn('link', event)
            self.assertIn('category', event)
            self.assertIn('city', event)
            self.assertIn('localization', event)

    def test_returns_correct_data_types(self):
        for event in self.events:
            self.assertIsInstance(event['title'], str)
            self.assertIsInstance(event['month'], str)
            self.assertIsInstance(event['day'], str)
            self.assertIsInstance(event['image'], str)
            self.assertIsInstance(event['link'], str)
            self.assertIsInstance(event['category'], str)
            self.assertIsInstance(event['city'], str)
            self.assertIsInstance(event['localization'], str)

class TestScrapeEventsData(unittest.TestCase):
    def setUp(self):
        self.events = scrape_events()

    def test_returns_correct_data(self):
        for event in self.events:
            self.assertTrue(event['title'])
            self.assertTrue(event['month'])
            self.assertTrue(event['day'])
            self.assertTrue(event['image'])
            self.assertTrue(event['link'])
            self.assertTrue(event['category'])
            self.assertTrue(event['city'])
            self.assertTrue(event['localization'])


if __name__ == '__main__':
    unittest.main()