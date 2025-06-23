// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

const allowedImageTypes = ["image/png", "image/jpg", "image/jpeg", "image/gif"]

document.addEventListener("trix-file-accept", e => {
  if (!allowedImageTypes.includes(e.file.type)) {
    e.preventDefault();
  } 
});
