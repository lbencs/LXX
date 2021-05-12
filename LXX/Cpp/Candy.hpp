//
//  Candy.hpp
//  CppOC
//
//  Created by lben on 2019/6/18.
//  Copyright © 2019 lben. All rights reserved.
//

#ifndef Candy_hpp
#define Candy_hpp

#include <stdio.h>

class Candy {
    int index;
    
public:
    void send(char *);
    void read(char **);
};

#endif /* Candy_hpp */
