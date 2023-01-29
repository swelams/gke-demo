pipeline {
    agent any
    parameters {
        string(name:'project-name', defaultValue:'', description:'this paramater help you to know project name')
       
    }

    stages {
        stage('check') {
            steps {
                echo "checking your code"
            }
        }

        stage('test') {
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
