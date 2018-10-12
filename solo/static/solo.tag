<solo>
    <div class="solo-topics">
        <div class="container form-group">
            <autotags label="topics" options={ fetch('/tags') } onupdate={ onTags }></autotags><br />
            <div class="row">
                <div sytle="width: 70%" class="column graph_div"><img src={ responseGraph() } class="solo-img"></div>
                <div style="width: 30%;" class="column" id="chartContainer"></div>
            </div>
        </div><br />
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
        </div><br />
    </div>
        <div>
            <dftable header={ response.tableheader } data={ response.fakemails } width="100" height="auto"></dftable>
        </div>
    </div>

    <style>
        .container {
            height: auto;
        }
        
        .column {
            float: left;
        }

        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        .bar_graph {
            width: 30%;
            height: 370px;
            margin: 10px;
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

    showResults = false;

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

    this.matches = {}
    
    search(tags) {
        fetch('/search', {method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(tags)})
            .then(response => response.json())
            .then(response => {
                this.response = response
                this.update()
            })

        console.log(this.matches)
        showResults = true;
     
        var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true,
            
            title:{
                text:"People of Relevance"
            },
            axisX:{
                interval: 1
            },
            axisY2:{
                interlacedColor: "rgba(1,77,101,.2)",
                gridColor: "rgba(1,77,101,.1)",
            },
            data: [{
                type: "bar",
                name: "people",
                axisYType: "secondary",
                color: "#014D65",
                dataPoints: [{ y: 34, label: "James" },
                { y: 31, label: "Fred" },
                { y: 28, label: "Jane" },
                { y: 18, label: "Mark" },
                { y: 12, label: "Wilma" },
                { y: 10, label: "Sarah" },
                { y: 8, label: "Ada" },
                { y: 8, label: "Graham" },
                { y: 5, label: "Lila" }]
            }]
        });

        chart.render();
    }
        
    
    

</solo>