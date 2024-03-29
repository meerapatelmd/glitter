# glitter 0.7.3.9000  

* Added `tag` features to assist in versioning.  
* Add `copy_branch()`  
* Added ability to add command line arguments to `pull()` and 
`push()`.  
* Added features that assist in versioning across NEWS.md, 
DESCRIPTION, and the repo tag.  
* Fixed bug in `delete_branch()`, changed `has_vignettes` 
argument in `deploy_*` packages to `build_vignettes`. Vignettes 
can be knit separatedly using the new `knit_vignettes` function 
prior to deployment.  
* Add magrittr package dependency to import pipe on load  
* Converted to tidy style  

## Issues  

* How can a release automatically be made in GitHub with each new version?  
* Move the mparse function to rubix    

# glitter 0.7.3  

* Add `is_man()` and `is_master()`  
* `branch()` invisibly returns branch names   
* Automatically substitute `master` with `main` at `push()`  


# glitter 0.6.4  

* Remove deprecated functions  


# glitter 0.6.4  

* Bug fix `issues` functions  
* Change argument of `clone()` from `clone_url` to github user and repo   


# glitter 0.6.2.9000   

* Add filter to `github api` functions for only the github user's repos   
* Add function that retrieves tag/release history for a github user's repo   
* Rename `path_to_local_repo` arguments to `path`   


# glitter 0.6.1   

* First Release  





