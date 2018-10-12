<dftable>

    <table style={ 'width:' + opts.width + '%' }>
        <thead>
            <tr>
                <th each={ opts.header } style={ 'width:' + width + '%' }>
                    { name }
                </th>
            </tr>
        </thead>
        <tbody style={ 'height:' + opts.height; }>
            <tr each={ datum in opts.data }>
                <td each={ opts.header } style={ 'width:' + width + '%' }>
                    <pre> { datum[key] } </pre> 
                </td>
            </tr>
        </tbody>
    </table>

    <style>
        table {
            border-spacing: 0px;
        }

        thead {
            background-color: #f0f0f0;
            display: block;
        }

        th {
            padding: 5px;
        }

        tbody {
            overflow-x: hidden;
            overflow-y: auto;
            display: block;
        }

        td {
            text-align: left;
            padding-right: 8px;
            padding-left: 8px;
        }

        tbody>tr:nth-child(even) {
            background-color: #f8f8f8;
        }
    </style>

</dftable>