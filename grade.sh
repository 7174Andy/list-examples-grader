CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point
output=$(find student-submission -name "*.java")
if [[ -e $output ]] && [[ $output == *ListExamples* ]]
then 
    echo file found
else
    echo file not found
    exit 1
fi

cp -r student-submission/ListExamples.java grading-area


# Then, add here code to compile and run, and do any post-processing of the
# tests
javac grading-area/ListExamples.java
error=$?

if [[ $error != 0 ]]
then 
    echo error occurred
    exit 1
else
    echo compiled successfully
fi

cp TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples
