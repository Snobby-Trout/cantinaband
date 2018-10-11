<autotags>

    <div class="form-autocomplete">
        <div class="form-autocomplete-input form-input">
            <virtual each={ selected }>
                <label class="chip" onclick={ () => remove(name) }>
                    { name }<button class="btn btn-clear"></button>
                </label>
            </virtual>
            <input class="form-input" type="text" ref="label" placeholder={ label } onkeydown={ keyDown } onkeyup={ keyUp }>
        </div>
        <ul if={ filtered.length > 0 } class="menu">
            <li each={ filtered }>
                <a class="btn btn-link" onclick={ () => add(name) }>
                    { name }
                </a>
            </li>
        </ul>
    </div>

    <style>
        label.chip {
            border-radius: .2rem;
        }
        ul.menu>li {
            margin-top: 0px;
        }
    </style>

    this.label = opts.label

    this.options = []
    this.selected = []
    this.filtered = []

    this.on('mount', function() {
        if( this.options.length === 0 ) {
            opts.options
                .then(response => response.json())
                .then(response => {
                    this.options = response
                    this.update()
                })
        }
    })

    onchange() {
        let values = []
        for(let i = 0; i < this.selected.length; i++) {
            values.push(this.selected[i].name)
        }
        (this.opts.onupdate||function(){})(values)
    }

    keyDown(evt) {
        if( evt.keyCode == 9 ) { // tab
            this.filtered = []
            this.update()
        }
    }

    keyUp(evt) {
        if( evt.keyCode == 27 ) { // escape - clear input
            this.clear()
            return
        }

        if( evt.keyCode == 13 ) { // enter - add contents of input
            this.add(this.refs.label.value)
            return
        }

        this.filtered = []

        let s = this.refs.label.value

        if( s.length == 0 ) {
            this.update()
            return
        }

        for(let j = 0; j < this.options.length; j++) {
            if( this.indexOf(this.selected, this.options[j]) != -1 )
                continue
            let opt = this.options[j]
            if( opt.toLowerCase().indexOf(s.toLowerCase()) != -1 )
                this.filtered.push({name: opt})
        }

        this.update()
    }

    clear() {
        this.refs.label.value = ''
        this.filtered = []
        this.update()
    }

    add(name) {
        this.selected.push({name: name})
        this.onchange()
        this.clear()
    }

    remove(name) {
        let idx = this.indexOf(this.selected, name)
        if( idx == -1 )
            return
        this.selected.splice(idx, 1)
        this.onchange()
        this.update()
    }

    indexOf(list, name) {
        for(let i = 0; i < list.length; i++) {
            if( list[i].name == name )
                return i
        }
        return -1
    }

</autotags>