      program basic04
!
!     This program builds on program basic01 to demonstrate blocking using the
!     `$OMP BARRIER` directive.
!
!     Hrant P. Hratchian, 2021.
!
!
      USE OMP_LIB
      implicit none
      integer :: threadNum,i
!
!     Begin by setting the number of OpenMP threads. This is done in lieu of
!     using the system environmental variable OMP_NUM_THREADS.
!
      call omp_set_num_threads(3)
!
!     Start an OpenMP parallel block of code. Each OMP worker is going to write
!     out a series of numbers and then tell us that it's done with its work.
!
!     In this version of the code (which is direcly based on program basic01),
!     we use blocking to ensure all of the OMP workers have finished writing out
!     their "threadNum,i: #" output before printing that they are each done with
!     their individual job.
!
!$OMP PARALLEL PRIVATE(threadNum,i)
      threadNum = OMP_GET_THREAD_NUM()
      if(threadNum.eq.0) then
        do i = 0,OMP_GET_MAX_THREADS()-1
          print *, 'threadNum,i: ',threadNum,i
        endDo
      endIf
!$OMP END PARALLEL
!$OMP PARALLEL PRIVATE(threadNum,i)
      threadNum = OMP_GET_THREAD_NUM()
      if(threadNum.eq.1) then
        do i = 0,OMP_GET_MAX_THREADS()-1
          print *, 'threadNum,i: ',threadNum,i
        endDo
      endIf
!$OMP END PARALLEL
!$OMP PARALLEL PRIVATE(threadNum,i)
      threadNum = OMP_GET_THREAD_NUM()
      if(threadNum.eq.2) then
        do i = 0,OMP_GET_MAX_THREADS()-1
          print *, 'threadNum,i: ',threadNum,i
        endDo
      endIf
!$OMP END PARALLEL
!$OMP PARALLEL PRIVATE(threadNum,i)
      print *, 'DONE with my work, threadNum ',threadNum
!$OMP END PARALLEL
!
      print *, 'END OF THE PROGRAM'
      end program basic04
