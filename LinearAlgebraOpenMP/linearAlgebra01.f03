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
      USE OMP_LIB
      implicit none
      integer,parameter::iOut=6
      integer::nDim,nOMP,i,j,k
      real::tStart,tEnd,tmp
      real,dimension(:,:),allocatable::matrixA,matrixB,matrixC
      character(len=256)::commandLineArg
      logical::fail=.false.
!
!     Format statements.
!
 1000 Format('My Matrix Multiplication: nDim = ',I10,'  Job Time: ',F10.3,' s.')
 8999 format(1x,'The program and completed normally.')
 9000 format(1x,'Wrong number of command line arguments found.')
 9999 Format(1x,'The program FAILED!')
!
!     Begin by loading nDim and nOMP from the command line arguments. Then,
!     allocating memory for matrixA, matrixB, and matrixC and start up OpenMP.
!
      if(COMMAND_ARGUMENT_COUNT().ne.2) then
        write(iOut,9000)
        fail = .true.
        goto 999
      endIf
      call GET_COMMAND_ARGUMENT(1,commandLineArg)
      read(commandLineArg,*) nDim
      call GET_COMMAND_ARGUMENT(2,commandLineArg)
      read(commandLineArg,*) nOMP
      Allocate(matrixA(nDim,nDim),matrixB(nDim,nDim),matrixC(nDim,nDim))
      call random_number(matrixA)
      call random_number(matrixB)
      call omp_set_num_threads(nOMP)
!
!     Carry out matrix multiplication using explicit nested loops.
!
      call CPU_TIME(tStart)
!$OMP PARALLEL DO Shared(matrixA,matrixB,matrixC,nDim,tmp) Reduction(+: tmp)
      do i = 1,nDim
        do j = 1,nDim
          tmp = float(0)
          do k = 1,nDim
            tmp = tmp + matrixA(i,k)*matrixB(k,j)
          endDo
          matrixC(i,j) = tmp
        endDo
      endDo
!$OMP END PARALLEL DO
      call CPU_TIME(tEnd)
      write(iOut,1000) nDim,tEnd-tStart
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
