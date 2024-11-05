from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()

def sel_open_browser(base_url):
    driver.get(base_url)

def sel_input_text_by_id(element, text):
    driver.find_element(By.ID, element).send_keys(text)