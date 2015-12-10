import urllib2
from cookielib import CookieJar
import os
import re
import time
import easygui


cookies = CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookies))
opener.addheaders = [('User-agent', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.17 '
                                    '(KHTML, like Gecko) Chrome/24.0.1312.27 Safari/537.17')]


def image_lookup(path):
    google_path = 'http://google.com/searchbyimage?image_url=' + path
    source = opener.open(google_path).read()
    # print(source) # Debug regex
    links = re.findall(r'"ou":"(.*?)","ow"', source)   # TODO is this robust?
    return links


def image_scrape(links, path):
    for link in links:
        # print link    # Debug
        filename = link.split('/')[-1].split('.')[0]
        ext = '.' + link.split('.')[-1]

        print "Link : " + link

        # Save Image
        try:    # Try to Download Image and print if error
            img = urllib2.urlopen(link)
            filepath = os.path.join(path, filename + ext)
            print filepath
            with open(filepath, 'wb') as local_file:
                local_file.write(img.read())
                print "Saved: " + filename

        except urllib2.URLError, err:   # TODO Why are some links "Bad Request"
            # print err.read()
            print err.reason
            print "Error"





def valid_url(url):		# check valid url
    regex = re.compile(
        r'^https?://'  # http:// or https://
        r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+[A-Z]{2,6}\.?|'  # domain...
        r'localhost|'  # localhost...
        r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' # ...or ip
        r'(?::\d+)?'  # optional port
        r'(?:/?|[/?]\S+)$', re.IGNORECASE)
    return url is not None and regex.search(url)


def main():							# TODO allow local picture file input
    url = easygui.enterbox(msg='Image URL: ', title='Input URL', default='', strip=True)
    path = easygui.diropenbox(msg='Image Save Path : ', title="Save Path", default='')
    if not valid_url(url):
        print "Error: Not valid URL"
    start = time.time()
    links = image_lookup(url)   # search for similar
    image_scrape(links, path)         # save results
    end = time.time()   # Debug runtime
    print "Search Time: " + str(end - start) + ' seconds'

main()
