import time
import concurrent.futures


start = time.perf_counter()


def do_something(seconds):
	print(f"Sleeping for {seconds} second(s)...")
	time.sleep(seconds)
	return f"Done Sleeping...{seconds}"


with concurrent.futures.ThreadPoolExecutor() as executor:
	seconds = [5, 4, 3, 2, 1]
	results = executor.map(do_something, seconds)
	
	for result in results:
		print(result)
		
finish = time.perf_counter()

print(f"Finished in {round(finish-start, 5)} second(s)")
