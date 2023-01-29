pipeline {
    agent any
    parameters {
        booleanParam(name:'project', defaultValue: true, description:'this paramater help you to know project name')
        choice(name: 'version', choices:['1.2','1.3','1.4'], description: '' )
        string(name: 'namespace', defaultValue: prod, description: '' )
       
    }

    stages {
        stage('check') {
            steps {
                echo "checking your code"
                echo params.version
                echo params.namespace
            }
        }

        stage('test') {
            when {
                expression{
                    params.project
                }
            }
            steps {
                echo "testing your app" 
            }
        }
        
        stage('deployment') {  
            steps {
                echo "your code is deployed right now"
            }
        }    
    }

}
