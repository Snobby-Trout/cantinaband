import base64, bottle, pandas as pd, threading


_lock = threading.Lock()
_topics = []
_graph_bytes = open('solo/facebook-graph-search-job-search.jpg', 'rb').read()
_pandas_df = pd.read_csv('solo/stock_1ad.csv')
_pandas_table_header = [{'name': 'Date', 'key': 'date', 'width': 100}, {'name': 'Open', 'key': 'open', 'width': 100},
                        {'name': 'Low', 'key': 'low', 'width': 100}, {'name': 'High', 'key': 'high', 'width': 100},
                        {'name': 'Close', 'key': 'close', 'width': 100}, {'name': 'Volume', 'key': 'volume', 'width': 100}]


def init():
    # do model initialisation stuff here
    # append your topic tags to _topics
    # replace the below:
    _topics.append('Alternative Facts')
    _topics.append('Baseball')
    _topics.append('Democrats')
    _topics.append('Donald Trump')
    _topics.append('Energy Revenue')
    _topics.append('Health Care')
    _topics.append('Hillary Clinton')
    _topics.append('Scandal')
    _topics.append('Tipping')


@bottle.get('/tags')
def tags():
    bottle.response.add_header('content-type', 'application/json')
    return bottle.json_dumps(_topics)


@bottle.post('/search')
def search():
    with _lock:
        # do your model lookup stuff here - _lock protects it against multiple users making queries at the same time
        # bottle.request.json is a ready to go python dict
        print(bottle.request.json)
        # replace matches with the result of your model search, sorted by score, keep the same JSON structure
        # replace _graph_bytes with the binary data for your image, use io.BytesIO to save a PIL image into bytes
        # data:image/jpeg;base64 IS important - replace jpeg with png for png format
        matches = {
            'matches': [{
                'name': 'Barack Obama', # or email - both?
                'score': 0.97,
                'likes': ['Democrats', 'Health Care']  # other top topics present in person's emails
            }, {
                'name': 'Bill Clinton',
                'score': 0.45,
                'likes': ['Alternative Facts', 'Scandal']
            }],
            'graph': 'data:image/jpeg;base64,' + base64.b64encode(_graph_bytes).decode('latin1'),
            'dataframe': list(_pandas_df.transpose().to_dict().values()),
            'tableheader': _pandas_table_header
        }
        return bottle.json_dumps(matches)