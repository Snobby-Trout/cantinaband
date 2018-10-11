<solo>
    <div class="solo-topics">
        <div class="container form-group">
            <autotags label="topics" options={ fetch('/tags') } onupdate={ onTags }></autotags><br />
            <div>
                <img class="graph_div" src={ responseGraph() } class="solo-img">
                <div class="sender_results">
                    <table hide={noResults}>
                        <thead>
                            <tr>
                                <td>key</td>
                                <td>value</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr each={this.senders}>
                                <td>{key}</td>
                                <td>{value}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div> <br />
        <div each={ response.matches } class="card solo-card">
            <div class="card-header">
                <div class="card-title h5">{ name }</div>
                <div class="card-subtitle text-gray">Score: { score }</div>
            </div>
            <div class="card-body">
                <div each={ topic, i in likes }>
                    { topic }
                </div>
            </div>
            </li>
        </div>
    </div>
    </div>

    <style>
        .container {
            height: auto;
        }

        .sender_results {
            float:right;
            width: 30%;
        }

        .graph_div {
            float:left;
            width: 70%;
        }

        .solo-topics {
            margin: 32px;
        }

        .solo-img {
            padding-left: 16px;
            padding-right: 16px;
            max-width: 100%;
        }

        .solo-card {
            display: inline-block;
            margin: 16px;
        }
    </style>

    response = {};

    noResults = true;

    responseGraph() {
        return this.response.graph || ''
    }

    this.senders = []

    // riot.mount('testtable', {rows: this.data, start: new Date})[0]

    onTags(tags) {
        console.log('searching for', tags)
        if( tags.length == 0 ) {
            this.response = {}
            this.update()
            return
        }
        this.search(tags)
    }

    search(tags) {
        fetch('/search', {method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(tags)})
            .then(response => response.json())
            .then(response => {
                this.response = response
                this.update()
            })

            for (var i = 0; i < 10; i++) {
                this.senders.push({
                key: `test sender ${i}`,
                value: 10 - i
            })

            noResults = false;
        }
        
    }

</solo>