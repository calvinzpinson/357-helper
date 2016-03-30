#!/bin/bash
#-----------------------------------------------------------
# Calvin Pinson
# 3.28.16
# Helper script to make life in 357 slightly less hellish
#-----------------------------------------------------------

USAGE="Usage: helper semester assignment. Example: helper S16 Exercise2"

#------- Option Processing ---------------------------------
if [ "$1" == "-h" ] ; then
      echo $USAGE
         exit 0;
      fi

      if [[ $# -eq 0 ]] ; then
            echo $USAGE
               exit 0;
            fi
            #------ End Option Processing ------------------------------

            echo "[+]Copying makefile to current directory..."
            cp ~kmammen-grader/evaluations/$1/357/$2/Makefile .

            echo "[+]Removing old test.txt file..."
            rm test.txt

            echo "[+]Making new test.txt file..."
            touch test.txt

            echo "****************************************" >> ./test.txt
            echo "               Test List                " >> ./test.txt
            echo "****************************************" >> ./test.txt
            echo "                                        " >> ./test.txt

            echo "[+]Getting test list file..."
            cat ~kmammen-grader/evaluations/$1/357/$2/tests/requirements/testList >> ./test.txt
            echo "                                        " >> ./test.txt
            echo "****************************************" >> ./test.txt
            echo "               Core Tests               " >> ./test.txt
            echo "****************************************" >> ./test.txt
            echo "                                        " >> ./test.txt

            counter=0
            echo "[+]Getting feature test files..."


            echo "****************************************" >> ./test.txt
            echo "             Feature Tests              " >> ./test.txt
            echo "****************************************" >> ./test.txt
            echo "                                        " >> ./test.txt

            for filename in ~kmammen-grader/evaluations/$1/357/$2/tests/feature/test*/description; do
                  echo "Feature Test: ""$counter" >> ./test.txt

                     cat "$filename" >> ./test.txt
                        echo "                                        " >> ./test.txt
                           counter=$[$counter +1]
                        done

                        echo "                                         " 
                        echo "[+]Attempting to compile..."
                        echo "                                         " 

                        for filename in ./*.c; do
                              echo "[*]compiling""$filename""..."
                                 make $filename
                                    echo " "
                                 done

                                 echo "[+]Begin stylechecking... "
                                 for filename in ./*.c; do
                                       echo " "
                                          echo "[*]stylechecking ""$filename""..."
                                             ~kmammen-grader/bin/styleCheckC $filename
                                                echo " "
                                             done

                                             echo "[+]Begin testing..."
                                             echo " "

                                             for testInput in ./tests/*.in; do
                                                   # Strip off the file extension, i.e., the ".in"
                                                      name=${testInput%.in}
                                                         echo "[*]Running ""$name""..."
                                                            # Run the test
                                                               a.out < $testInput > $name.out
                                                                  echo "[*]Diffing ""$name""..."
                                                                     # diff the results
                                                                        diff -q $name.out $name.expect
                                                                           echo " "
                                                                        done

