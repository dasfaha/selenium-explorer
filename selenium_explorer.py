#This program is made available under the GNU license
#Author:David Asfaha
#E-mail:davidasfaha@gmail.com


from bottle import route, run, template, view, debug
#line below is for debugging
import code
import pdb
from selenium import webdriver

STARTING_XPATH = '//*'
start_url = "http://www.economist.com/node/21555923"
current_url = None
browser = None

#These variables hold the xpath as we traverse the page, and the elements visited on this path
#xpath_by_level = []
elem_list = []

class page_level:
    elems = None
    level = None
    xpath = None
         
def xpath_of_web_elements_list(elems):
    pass

app_state = {}
def init():
#    global browser, elems,elem_list, xpath_by_level
    global browser, elem_list
    browser = webdriver.Firefox()
    browser.get(start_url)
    elem_list.append(browser.find_elements_by_xpath(STARTING_XPATH))
    #xpath_by_level.append(STARTING_XPATH)

@route("/follow_element/<level:int>/<elem_pos:int>")
def follow_element(level, elem_pos):
    global elem_list
    req_response = {}
    level_index = int(level)
    elem_pos_index = elem_pos
    next_level = level+1
    #Check that level is not out of bounds of elem_list
    if level_index + 1 > len(elem_list):
        req_response['error'] = "Level requested not availabled in html content representation"
    if elem_list[level_index]:
        sub_elem = elem_list[level_index][elem_pos_index].find_elements_by_xpath('*')
        #req_response['sub_elem_count'] = len(sub_elem)
        #If current level is last in elem_list then append new elements in a new level
        if len(elem_list) == next_level:
            elem_list.append(sub_elem)
        #if next level already contains elements replace them with the ones obtained here
        else:
            elem_list[next_level] = sub_elem
#        req_response['element_list'] = elem_list[-1:]
        req_response = dict(element_list=[x.tag_name for x in elem_list[next_level][:-1]], level=next_level)   
    return req_response

@route("/")
@view("home")
def home():
    global start_url, elem_list
    assert elem_list
    start_vars = dict(url=start_url,element_list=elem_list, level=0)
    return start_vars

@route("/get_console")
def get_console():    
    pdb.set_trace()


init()      
debug(True)
run(host='localhost', port=8080)




