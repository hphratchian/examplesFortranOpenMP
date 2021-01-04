      program basic01
!
!     This program demonstrates some of the most basic features of coding with
!     the OpenMP library for shared-memory parallelism.
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
!$OMP PARALLEL PRIVATE(threadNum)
      threadNum = OMP_GET_THREAD_NUM()
      do i = 0,OMP_GET_MAX_THREADS()-1
        print *, 'threadNum,i: ',threadNum,i
      endDo
      print *, 'DONE with my work, threadNum ',threadNum
!$OMP END PARALLEL
!
      print *, 'END OF THE PROGRAM'
      end program basic01
