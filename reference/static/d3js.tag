<d3js>

    <div>
        <svg ref="d3"></svg>
    </div>

    this.on('update', function() {
        console.log('rendering') // called each time the containing riotjs widget is updated

        let svg = this.refs.d3

        while( svg.firstChild ) {
           svg.removeChild(svg.firstChild)
        }

        // pass in data and use via opts.data - similar to dftable

        // do d3 javascripty stuff here
    })

</d3js>