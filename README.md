# flico

## Description

A command line tool to create collage using Flicr Images using MiniMagick Montage. It accepts 10 search keywords as arguments then, queries the Flickr API to fetch an image for each keyword, assembles a collage and saves with user given file name.

If given less than ten keywords, or if any keyword fails to result in a match, it retrieves random words from a dictionary source such as `/usr/share/dict/words`.

## Setup

1. [ImageMagick](http://www.imagemagick.org/). Use Homebrew for OSX `brew install imagemagick`

2. Flickr API Key and Secret. Set them as environment variables, 

	`export FLICKR_KEY=**************`
	
	`export FLICKR_SECRET=*******`

3. Install gem using: `gem install flico`

4. Make a collage using: `flico -f file_name keyword1 keyword2, keyword3, keyword4, keyword5...`
