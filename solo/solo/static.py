import bottle, os


@bottle.get('/')
@bottle.get('/<path:path>')
def static(path: str = 'index.html') -> None:
    return bottle.static_file(path, os.path.abspath('static'))
