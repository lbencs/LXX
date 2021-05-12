//
//  Candy.cpp
//  CppOC
//
//  Created by lben on 2019/6/18.
//  Copyright © 2019 lben. All rights reserved.
//

#include "Candy.hpp"

using namespace std;

void Candy::send(char * str) {
    printf("%s", str);
}

void Candy::read(char ** str) {
    *str = "hello world!";
}
