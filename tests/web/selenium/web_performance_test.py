from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import os

def web_performance_test():
    remote_url = os.getenv("SELENIUM_URL", "http://localhost:4444/wd/hub")

    chrome_options = Options()
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    driver = webdriver.Remote(
        command_executor=remote_url,
        options=chrome_options
    )

    print(f"remote_url: {remote_url}")


    driver.get('https://www.google.com')
    start_time = time.time()

    search_box = driver.find_element(By.NAME, 'q')
    search_box.send_keys('Selenium performance testing')
    search_box.submit()

    time.sleep(3)

    load_time = time.time() - start_time
    print(f"Web UI load time: {load_time:.2f} seconds")

    driver.quit()

if __name__ == "__main__":
    web_performance_test()
