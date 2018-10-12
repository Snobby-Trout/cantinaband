<top_people>
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

    <style>
    </style>

    noResults = true;

    this.senders = []

    update() {
        for (var i = 0; i < 10; i++) {
            this.senders.push({
                key: `test sender ${i}`,
                value: 10 - i
            })
        }
        noResults = false;
    }


</top_people>