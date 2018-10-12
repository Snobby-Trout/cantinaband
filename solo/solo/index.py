import base64, bottle, threading, pickle
import numpy as np
import json


_relevant_people = [{ 'y': 34, 'label': "James" },
                    { 'y': 31, 'label': "Fred" },
                    { 'y': 28, 'label': "Jane" },
                    { 'y': 18, 'label': "Mark" },
                    { 'y': 12, 'label': "Wilma" },
                    { 'y': 10, 'label': "Sarah" },
                    { 'y': 8, 'label': "Ada" },
                    { 'y': 8, 'label': "Graham" },
                    { 'y': 5, 'label': "Lila" }]

_lock = threading.Lock()
_topics = []
_graph_bytes = open('solo/facebook-graph-search-job-search.jpg', 'rb').read()
_fakemails = json.load(open('./fakemails.json','rb'))


_fakemails_table_header = [{'name': 'FakeEmailGenerated', 'key': 'fakemail', 'width': 100}] 

#TODO: Add pickle loading of email embeddings
_emailEmbeddings = np.zeros([10,512])

def init():
    # do model initialisation stuff here
    # append your topic tags to _topics
    # replace the below:

    [_topics.append(fake['topic']) for fake in _fakemails]
    


def calculateEmbedding(seachList):
    #TODO: Implement embedding
    return np.zeros([512])

@bottle.get('/tags')
def tags():
    bottle.response.add_header('content-type', 'application/json')
    return bottle.json_dumps(_topics)


def embeddingSearch(embedding, threshold=0.9):
    #TODO: Implement pytorch embedding search
    listOfCalculatedIndices = []
    return listOfCalculatedIndices

def getReturnedEmails(indices):
    return None

@bottle.post('/search')
def search():
    with _lock:
        # do your model lookup stuff here - _lock protects it against multiple users making queries at the same time
        # bottle.request.json is a ready to go python dict
        tags = bottle.request.json

        # calculate the embedding from the request
        embedding = calculateEmbedding(tags)

        selected_topics = []
        for fake in _fakemails:
            if fake['topic'] in tags:
                fake_html = fake['fakemail']
                selected_topics.append({'fakemail': fake_html })

        # get an array of distances
        calculatedIndices = embeddingSearch(embedding)

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
            'relevant_people': _relevant_people,
            'fakemails': selected_topics,
            'tableheader': _fakemails_table_header
        }
        return bottle.json_dumps(matches)