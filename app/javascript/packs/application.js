// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import "core-js/stable";
// import "regenerator-runtime/runtime";

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap/dist/js/bootstrap")
require('../scss/manifest.scss')

const images = require.context('../../assets/images', true)
const imagePath = (name) => images(name, true)