from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import os

class TestGoogleSearch:
    def createModel():
        service = Service(ChromeDriverManager().install())
        options = webdriver.ChromeOptions()
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")

        driver = webdriver.Chrome(service=service, options=options)
        return driver

    def test_web_performance(self):
        driver = webdriver.Chrome()  # Sử dụng ChromeDriver
        driver.get('https://www.google.com')

        start_time = time.time()

        search_box = driver.find_element_by_name('q')
        search_box.send_keys('Selenium performance testing')
        search_box.submit()

        time.sleep(3)  # Đợi trang tải kết quả

        load_time = time.time() - start_time
        print(f"Web UI load time: {load_time} seconds")

        driver.quit()

    if __name__ == "__main__":
        web_performance_test()