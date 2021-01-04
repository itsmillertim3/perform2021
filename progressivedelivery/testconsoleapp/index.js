#!/usr/bin/env node

// Credits go to https://developer.okta.com/blog/2019/06/18/command-line-app-with-nodejs where I found this code

const yargs = require("yargs");
const axios = require("axios");
const read = require('readline-sync');

const options = yargs
 .usage("Usage: -n <name>")
 .option("n", { alias: "name", describe: "Your name", type: "string", demandOption: true })
 .option("s", { alias: "search", describe: "Search term", type: "string" })
 .argv;

const greeting = `Hello, ${options.name}!`;
console.log(greeting);

var continueWithJokes = "yes"

var getJoke = function() {
    if (options.search) {
    console.log(`Searching for jokes about ${options.search}...`)
    } else {
    console.log("Here's a random joke for you:");
    }

    // The url depends on searching or not
    const url = options.search ? `https://icanhazdadjoke.com/search?term=${escape(options.search)}` : "https://icanhazdadjoke.com/";

    axios.get(url, { headers: { Accept: "application/json" } })
    .then(res => {
    if (options.search) {
        // if searching for jokes, loop over the results
        res.data.results.forEach( j => {
        console.log("\n" + j.joke);
        });

        if (res.data.results.length === 0) {
        console.log("no jokes found :'(");
        }
    } else {
        console.log(res.data.joke);
    }

    continueWithJokes = read.question('Ready for another one? (yes/no)? ', {
        hideEchoBack: false // The typed text on screen is hidden by `*` (default). 
    });

    if (continueWithJokes == "yes") {
        getJoke()
    }

    });    
}

getJoke()
