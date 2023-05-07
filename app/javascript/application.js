let state = {
    pokemon: '',
    spriteUrl: '',
    horoscope: ''
}

function Binding(b) {
    let _this = this
    this.element = b.element    
    this.value = b.object[b.property]
    this.attribute = b.attribute
    this.valueGetter = function(){
        return _this.value;
    }
    this.valueSetter = function(val){
        _this.value = val
        _this.element[_this.attribute] = val
    }

    Object.defineProperty(b.object, b.property, {
        get: this.valueGetter,
        set: this.valueSetter
    }); 
    b.object[b.property] = this.value;
    this.element[this.attribute] = this.value
}

const initializePokemon = async () => {
    let lastVisited = localStorage.getItem('lastVisited');
    if (lastVisited === null || new Date(lastVisited).getDay() !== new Date(Date.now()).getDay()) {
        lastVisited = Date.now();
        localStorage.setItem('lastVisited', lastVisited);
        return await fetchPokemon();
    }
    return {
        pokemon: localStorage.getItem('pokemon'),
        spriteUrl: localStorage.getItem('spriteUrl'),
        horoscope: localStorage.getItem('horoscope')
    }
}

const fetchPokemon = async (pokemon) => {
    // TODO: Add missingno as 0th pokemon
    const pokeId = Math.ceil((Math.random() * 365)) ;
    const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokeId}`, {method: "GET"});
    const pokeInfo = await response.json();
    return {
        pokemon: pokeInfo.name,
        spriteUrl: pokeInfo.sprites.front_default,
        horoscope: null
    };
}

const fetchHoroscope = async (pokeName) => {
    try {
    const horoscopePrompt = `write me a three sentence horoscope based on the pokemon ${pokeName}`
    const origin = window.location.origin;
    const response = await fetch(
        `${origin}/prompt`,
        {
            method: 'POST',
            body: JSON.stringify(horoscopePrompt),
        }
    );
    return await response.json();
    }
    catch (error) {
        console.log(error);
    }
}

const horoscopeReady = async (fn) => {
    // If we're early to the party
    if (document.readyState !== 'loading') {
        fn();
    } else {
        document.addEventListener('DOMContentLoaded', () => {
            fn();
        });
    }
    const {pokemon, spriteUrl, horoscope} = await initializePokemon();
    state.pokemon = pokemon;
    state.spriteUrl = spriteUrl;
    state.horoscope = horoscope ? horoscope : await fetchHoroscope(pokemon);
    storeState();
}

const storeState = () => {
    localStorage.setItem("pokemon", state.pokemon);
    localStorage.setItem("spriteUrl", state.spriteUrl);
    localStorage.setItem("horoscope", state.horoscope);
}

horoscopeReady(async () => {
    const title = document.getElementById('horoscope_title');
    if (!title) return;
    const image = document.getElementById('horoscope_image');
    const text = document.getElementById('horoscope_text');
    new Binding({
        element: title,
        attribute: "innerHTML",
        object: state,
        property: 'pokemon'
    });
    new Binding({
        element: image,
        attribute: "src",
        object: state,
        property: 'spriteUrl'
    });
    new Binding({
        element: text,
        attribute: "innerHTML",
        object: state,
        property: 'horoscope'
    });
});