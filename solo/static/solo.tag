<solo>

    <div class="solo-topics">
        <div class="form-group">
            <autotags label="topics" options={ fetch('/tags') } onupdate={ onTags }></autotags><br/>
            <img src={ responseGraph() } class="solo-img">
            <div>
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

    response = {}

    responseGraph() {
        return this.response.graph || ''
    }

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
    }

</solo>