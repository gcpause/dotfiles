function __project_complete
    set -q PROJECT_DIRS; or return
    for dir in $PROJECT_DIRS
        if test -d $dir
            ls $dir
        end
    end
end

complete -c project -f -a "(__project_complete)"
