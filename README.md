# Y3



 - This project is for making my personal search results.

 - I plan to download all data from the YTS website into MySQL.

 - Then, query the database to get the results.

**Y**TS-**Y**AD-M**Y**SQL




### Install dependency

```
sudo apt install curl yad jq -y

```



# Get MOVIE_COUNT

```
curl -s "https://yts.mx/api/v2/list_movies.json?limit=1&page=1" | jq .data.'movie_count'
```
 

# Get IPAddress

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
</table>


