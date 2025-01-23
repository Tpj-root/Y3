# Y3



 - This project is for making my personal search results.

 - I plan to download all data from the YTS website into MySQL.

 - Then, query the database to get the results.

**Y**TS-**Y**AD-M**Y**SQL




### Site


```

https://eztvx.to/

https://yifystatus.com/

https://ytsproxies.com/


```







### Install dependency

```
sudo apt install curl yad jq -y

```



### Get MOVIE_COUNT

```
curl -s "https://yts.mx/api/v2/list_movies.json?limit=1&page=1" | jq .data.'movie_count'
```
 

### Get IPAddress

```
nslookup  www.yts.mx
```

<table>
  <tr>
    <th>DATE</th>
    <th>MOVIE_COUNT</th>
    <th>Domain</th>
    <th>IPAddress</th>
    <th>Status{Online, Down, Redirect}</th>
    <th>Sync{successfully, notyet}</th>
    <th>Summery</th>
  </tr>
<tr>
  <td style="width: 50px; word-wrap: break-word;">Jan 22 2025</td>
  <td style="width: 150px; word-wrap: break-word;">65026</td>
  <td style="width: 150px; word-wrap: break-word;">www.yts.mx</td>
  <td style="width: 150px; word-wrap: break-word;">104.26.0.60, 104.26.1.60, 172.67.69.153</td>
  <td style="width: 200px; word-wrap: break-word;">Online</td>
  <td style="width: 200px; word-wrap: break-word;">notyet</td>
  <td style="width: 200px; word-wrap: break-word;"></td>
</tr>
<tr>
  <td style="width: 50px; word-wrap: break-word;">Jan 23 2025</td>
  <td style="width: 150px; word-wrap: break-word;">65060</td>
  <td style="width: 150px; word-wrap: break-word;">www.yts.mx</td>
  <td style="width: 150px; word-wrap: break-word;">104.26.0.60, 104.26.1.60, 172.67.69.153</td>
  <td style="width: 200px; word-wrap: break-word;">Online</td>
  <td style="width: 200px; word-wrap: break-word;">notyet</td>
  <td style="width: 200px; word-wrap: break-word;">+34</td>
</tr>
</table>


```
curl -s "https://yts.mx/api/v2/list_movies.json?limit=1&page=1" | jq .data.'movie_count'
SELECT COUNT(*) FROM movies;
cat empty_slots_ids.txt | wc -l
cat Ihave_id.txt | wc -l

```


<table>
  <tr>
    <th>DATE</th>
    <th>BIG_COUNT_IDs</th>
    <th>MYSQL_IDs</th>
    <th>EMPTY_IDs</th>
    <th>IHAVA_IDs</th>
    <th>TOTAL_IDs</th>
    <th>-</th>
    <th>Summery</th>
  </tr>
<tr>

  <td style="width: 50px; word-wrap: break-word;">Jan 22 2025</td>
  <td style="width: 50px; word-wrap: break-word;">65026</td>
  <td style="width: 150px; word-wrap: break-word;">64342</td>
  <td style="width: 50px; word-wrap: break-word;">1106</td>
  <td style="width: 150px; word-wrap: break-word;">559</td>
  <td style="width: 200px; word-wrap: break-word;">64901</td>
  <td style="width: 200px; word-wrap: break-word;"></td>
  <td style="width: 200px; word-wrap: break-word;"> -125</td>
</tr>
</table>






```




# Notes



```
https://github.com/v1cont/yad

https://github.com/v1cont/yad/wiki

https://yad-guide.ingk.se/

https://yad-guide.ingk.se/notebook/yad-notebook.html

```




