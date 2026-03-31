function mci --wraps='maven clean install' --wraps='mvn clean install' --description 'alias mci=mvn clean install'
    mvn clean install $argv
end
