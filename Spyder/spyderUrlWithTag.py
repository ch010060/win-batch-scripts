import sys
import requests
import re
from bs4 import BeautifulSoup
from urllib.parse import urlparse
headers = {
 'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
}
url = sys.argv[1]
parsed_uri = urlparse(url)
domain = '{uri.scheme}://{uri.netloc}'.format(uri=parsed_uri)
rs = requests.Session()
resp = rs.get(url, headers=headers)
print(resp.status_code) #check web
soup = BeautifulSoup(resp.text, 'lxml')
a_tag = soup.find_all('a')
for tag in a_tag:
    ur = tag.get('href')
    if "http" in ur:
        print(ur)
    else:
        print(domain+ur)