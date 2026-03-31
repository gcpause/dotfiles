function project -d "cd into an aixigo-platform project"
    if test (count $argv) -eq 0
        echo "Usage: project <project-name>"
        echo "Available projects:"
        ls ~/export/aixigo-platform/
        return 1
    end

    set -l dir ~/export/aixigo-platform/$argv[1]

    if test -d $dir
        cd $dir
    else
        echo "Project '$argv[1]' not found in ~/export/aixigo-platform/"
        return 1
    end
end
