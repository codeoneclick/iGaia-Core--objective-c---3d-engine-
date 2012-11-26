//
//  iGaiaThreadQueue.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaThreadQueue.h"
#include <Python.h>


iGaiaThreadQueue::iGaiaThreadQueue(void)
{
    function<void()> loop = std::bind(&iGaiaThreadQueue::Loop, this);
    m_thread = thread(loop);
    
    /*PyObject *pName, *pModule, *pDict, *pFunc, *pValue;
    
    // Initialize the Python Interpreter
    Py_Initialize();
    
    // Build the name object
    pName = PyString_FromString("module.py");
    
    // Load the module object
    pModule = PyImport_Import(pName);
    
    // pDict is a borrowed reference
    pDict = PyModule_GetDict(pModule);
    
    // pFunc is also a borrowed reference
    pFunc = PyDict_GetItemString(pDict, "test");
    
    if (PyCallable_Check(pFunc))
    {
        PyObject_CallObject(pFunc, NULL);
    } else
    {
        PyErr_Print();
    }
    
    // Clean up
    Py_DECREF(pModule);
    Py_DECREF(pName);
    
    // Finish the Python Interpreter
    Py_Finalize();*/
}

iGaiaThreadQueue::~iGaiaThreadQueue(void)
{
    
}

void iGaiaThreadQueue::Loop(void)
{
    while(m_isStarted)
    {
        Py_SetProgramName("/usr/bin/python");
        Py_Initialize();
        PyRun_SimpleString("import os; os.system('say good night')");
        std::cout<<"THREAD !!!"<<std::endl;
        usleep(300);
    }
}

void iGaiaThreadQueue::Start(void)
{
    if(!m_isStarted)
    {
        
        m_isStarted = true;
    }
}

void iGaiaThreadQueue::Stop(void)
{
    m_isStarted = false;
}

void iGaiaThreadQueue::Dispatch(std::function<void()> _function)
{
    
}

