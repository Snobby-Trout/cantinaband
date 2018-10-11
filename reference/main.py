import bottle
import solo

solo.init()

try:
    import bjoern
except ImportError:
    bjoern = None

bottle.run(host='0.0.0.0', server='bjoern' if bjoern else 'wsgiref')