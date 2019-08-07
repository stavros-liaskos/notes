# Notes  
> A collection of helpful notes, simple solutions, hacks and things that I stumbled upon

## Usage with Docker 
*  Start development server on http://localhost:8000   
`docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material`

* Deploy documentation to GitHub Pages   
`docker run --rm -it -v ~/.ssh:/root/.ssh -v ${PWD}:/docs squidfunk/mkdocs-material gh-deploy`  
 
[source](https://hub.docker.com/r/squidfunk/mkdocs-material)


## License
[MIT](./LICENSE)
 
