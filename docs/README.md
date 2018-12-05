# Notes  
> A collection of helpful notes, simple solutions, hacks and things that I stumbled upon

## Installing MkDocs
Read the installation guide at the [official documentation](https://www.mkdocs.org/)

## Installing Material Design
Run the following command to install material design:  
```
pip install mkdocs-material
```  

For more information visit the [official repository](https://github.com/squidfunk/mkdocs-material)

## Set up MkDocs 
   
   * `mkdocs serve` - Start the live-reloading docs server.
   * `mkdocs build` - Build the documentation site.
   * `mkdocs help` - Print this help message.


## Deploy to GitHub Pages
First you need to symlink the `post-commit` script to `.git/hooks`:
```bash
cp hooks/post-commit .git/hooks/post-commit
```

After that, mkdocs are deployed to `gh-pages` branch after commit automatically by running the following script:
```
bash deploy.sh
```

## License
MIT
 
