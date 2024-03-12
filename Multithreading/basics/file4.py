import time
import concurrent.futures


start = time.perf_counter()


def do_something(seconds):
	print(f"Sleeping for {seconds} second(s)...")
	time.sleep(seconds)
	return f"Done Sleeping...{seconds}"


with concurrent.futures.ThreadPoolExecutor() as executor:
	seconds = [5, 4, 3, 2, 1]
	results = [executor.submit(do_something, sec) for sec in seconds]
	
	for f in concurrent.futures.as_completed(results):
		print(f.result())

"""
In order to get the results we can use the function as_completed from the concurrent.futures
module. This gives us an iterator that we can loop over that will yield the results of
our threads as they are completed.
"""
"""
submit method schedules a function to be executed and returns a future object

a future object encapsulates the execution of our function and allows us to
check in on it after it's been scheduled so we can check whether it is running
or if it's done and also check the result and if we get the result then 
it'll give us the return value of the function.
"""

finish = time.perf_counter()

print(f"Finished in {round(finish-start, 5)} second(s)")
