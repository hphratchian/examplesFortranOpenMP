      program linearAlgebra01
!
!     This program fills two matrices with random numbers and forms their sum.
!     The matrices are square and their size is determined by a user-provided
!     command line argument.
!
!
!     Hrant P. Hratchian, 2021.
!
!
      implicit none
      integer,parameter::iOut=6
      integer::nDim
      real::tStart,tEnd
      real,dimension(:,:),allocatable::matrixA,matrixB,matrixC
      character(len=256)::commandLineArg
      logical::fail=.false.
!
!     Format statements.
!
 8999 format(1x,'The program and completed normally.')
 9000 format(1x,'Wrong number of command line arguments found.')
 9999 Format(1x,'The program FAILED!')
!
!     Begin by loading nDim from the command line arguments and then allocating
!     memory for matrixA, matrixB, and matrixC.
!
      if(COMMAND_ARGUMENT_COUNT().ne.1) then
        write(iOut,9000)
        fail = .true.
        goto 999
      endIf
      call GET_COMMAND_ARGUMENT(1,commandLineArg)
      read(commandLineArg,*) nDim
      Allocate(matrixA(nDim,nDim),matrixB(nDim,nDim),matrixC(nDim,nDim))




!
!     Wrap up the program. First, check to see if we have hit a failure and
!     print an appropriate message. Then, deallocate memory for allocatable
!     arrays.
!
  999 if(fail) then
        write(iOut,9999)
      else
        write(iOut,8999)
      endIf
      DeAllocate(matrixA,matrixB,matrixC)
      end program linearAlgebra01
