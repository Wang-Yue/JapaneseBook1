#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

import urllib2, re, html2text, time
html2text.IGNORE_ANCHORS = True
html2text.IGNORE_IMAGES = True
html2text.IGNORE_EMPHASIS = True


def retrieve(x):
    (title, link)=x
    if u"第二册" in title: return
    title = title.replace("【已奖】", "").replace("【新编日语】", "").replace("第一册", "").replace("（修订版）", "")
    
    content = urllib2.urlopen(link).read()
    html_string_list = re.findall("""(<div class="menu_content font_smallContent wordbreak">.*?)<div class="gray" style="text-align: right">""", content, flags = re.DOTALL)        

    if len(html_string_list) == 1:
        text = html2text.html2text(html_string_list[0])        
        text = re.findall(ur"""不防碍大家的学习(.*)记住：日语越说就越流利""", text, flags = re.DOTALL)
        if len(text) == 1:
            open(title +'.text', 'w').write(text[0] + '\nSource: ' + link + '\n')
        else:
            print "[TXT]N/A ", link
            return 
        mp3_link = re.findall ("""[file|music]=(http[^><]*?mp3)[^><]*?width=200""", content)
        if len(mp3_link) == 0:
            print "[MP3]MISS", link 
        else:
            num = 0
            for mp3 in mp3_link:
                num += 1
                req = urllib2.Request(mp3, headers={'User-Agent' : "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36"})
                con = urllib2.urlopen(req)
                s = con.read()
                if "DOCTYPE" in s:
                    print "[MP3]FAIL", mp3
                else:
                    open(title + ' ' + str(num) +'.mp3', 'w').write(s)
    else:
        print "[TXT]FAIL", link  
    return 

if __name__ == '__main__':
    link_list = []
    for pagenum in range(4,10):
        content = urllib2.urlopen("http://bulo.hujiang.com/app/menu/8084/list?page={}&type=all".format(str(pagenum))).read()
        link_list += re.findall(r'title="(.*?)"\s*href="(http://bulo.hujiang.com/menu/8084/item/[0-9]*)"', content)
    link_list.reverse()
    #for i in link_list: retrieve(i)
    from multiprocessing import Pool
    pool = Pool(processes=200)              
    pool.map(retrieve, link_list)
        