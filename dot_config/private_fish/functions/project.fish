function project -d "cd into a project directory"
    # Default to empty if not set
    set -q PROJECT_DIRS; or begin
        echo "PROJECT_DIRS not set. Set it with:"
        echo "  set -Ux PROJECT_DIRS ~/path/to/projects1 ~/path/to/projects2"
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: project <project-name>"
        echo ""
        for dir in $PROJECT_DIRS
            if test -d $dir
                echo "Available projects in $dir:"
                ls $dir
                echo ""
            end
        end
        return 1
    end

    for dir in $PROJECT_DIRS
        set -l project_path $dir/$argv[1]
        if test -d $project_path
            cd $project_path
            return 0
        end
    end

    echo "Project '$argv[1]' not found in: $PROJECT_DIRS"
    return 1
end
