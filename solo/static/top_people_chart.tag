<top_people_chart>
    
    </div>

    <script>
    window.onload = function () {
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
                        dataPoints: [
                            { y: 34, label: "James" },
                            { y: 31, label: "Fred" },
                            { y: 28, label: "Jane" },
                            { y: 18, label: "Mark" },
                            { y: 12, label: "Wilma" },
                            { y: 10, label: "Sarah" },
                            { y: 8, label: "Ada" },
                            { y: 8, label: "Graham" },
                            { y: 5, label: "Lila" },
                        ]
                    }]
                });

        chart.render();
    }
    </script>

</top_people_chart>