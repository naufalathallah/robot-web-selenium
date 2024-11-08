from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()

def sel_open_browser(base_url):
    driver.get(base_url)

def sel_close_browser():
    driver.close()

def sel_input_text_by_id(element, text):
    driver.find_element(By.ID, element).send_keys(text)

def sel_click_element_by_xpath(element):
    driver.find_element(By.XPATH, element).click()

def sel_element_text_by_xpath_should_be(element, expected_text):
    displayed_text =  sel_get_text_by_xpath(element)
    assert displayed_text == expected_text, f"Expected title to be '{expected_text}' but got '{displayed_text}'"

def sel_get_text_by_xpath(element):
    text = driver.find_element(By.XPATH, element).text
    return text

def sel_get_web_elements_by_xpath(element):
    elements = driver.find_elements(By.XPATH, element)
    return elements

def sel_click_list_web_elements_by_xpath(list_element):
    for el in list_element:
        el.click()