com.lab49.tuesday
=====
Backstage templated application to generate a spring boot Restful microservice deployed to kubernetes.

Expressions such as 'tuesday' will be replaced by supplied during creation of an implementation of the template.

Available runtime values
- java_package_name: com.lab49
- component_id: tuesday
- description: demo for architecture
- artifact_id: tuesday
- owner: teama
- description: demo for architecture
- destination: lab49-poc/tuesday
- port:  8080

### the process

in backstage
1) from menu select Create... which shows page Create a New Component
2) choose Spring Boot Rest Service template
3) enter values across several steps
4) choose create:
- generates a new github repository https://github.com/lab49-poc/tuesday.git containing the skeleton project with runtime values substituted
- registers the component in backstage

on laptop
5) clone the generated project locally, develop the microservice wanted, commit and push back to git repository

back in backstage
6) github actions  [workflow](.github/workflows/build.yml) builds and deploys the microservice
- register api in backstage  TODO?
- deploy in k8s
- register api in kong developer portal TODO


need
1) github repository e.g https://github.com/lab49-poc where lab49-poc is github organisation representing a distinct owner CBA
2) github repository has secrets setup for k8s details e.g.
- AWS_ACCESS_KEY_ID: [refer](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds-create)
- AWS_SECRET_ACCESS_KEY: [refer](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds-create)
- KUBE_CONFIG: contains result of `cat ~/.kube/config | base64`
- ECR_REPOSITORY_NAME: : could be same name as organisation
- AWS_REGION : ap-southeast-2
- K8S_CLUSTER_NAME  : could be same name as organisation
3) AWS EKS cluster was created as per https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html
4) AWS ECR repository created as per
5) kong installed into AWS EKS as per [kong on aws workshop](https://kong.awsworkshop.io/introduction.html)

### build and run the generated project

```bash
git clone https://github.com/lab49-poc/tuesday.git

cd tuesday

./mvnw spring-boot:run

curl localhost:8080/greeting

{"id":1,"content":"Hello, World!"}

curl  http://localhost:8080/greeting?name=stephen

{"id":2,"content":"Hello, stephen!"}

curl  http://localhost:8080/actuator

{"_links":{"self":{"href":"http://localhost:8080/actuator","templated":false},"health-path":{"href":"http://localhost:8080/actuator/health/{*path}","templated":true},"health":{"href":"http://localhost:8080/actuator/health","templated":false},"info":{"href":"http://localhost:8080/actuator/info","templated":false}}}

```
