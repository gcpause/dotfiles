function project -d "cd into an aixigo-platform or aixigo-solutions project"
    if test (count $argv) -eq 0
        echo "Usage: project <project-name>"
        echo "Available projects in aixigo-platform:"
        ls ~/export/aixigo-platform/
        echo ""
        echo "Available projects in aixigo-solutions:"
        ls ~/export/aixigo-solutions/
        return 1
    end

    set -l dir_platform ~/export/aixigo-platform/$argv[1]
    set -l dir_solutions ~/export/aixigo-solutions/$argv[1]

    if test -d $dir_platform
        cd $dir_platform
    else if test -d $dir_solutions
        cd $dir_solutions
    else
        echo "Project '$argv[1]' not found in aixigo-platform or aixigo-solutions"
        return 1
    end
end
