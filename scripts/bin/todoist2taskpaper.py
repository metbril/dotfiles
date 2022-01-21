#!/usr/bin/python

# pip install requests
# pip install pytodoist

import argparse
from pytodoist import todoist

def run():
	user = todoist.login('kersublatest@robertvanbregt.nl', 's8/%6#%G;xN%~WNWH6?t')
	projects = user.get_projects()
	for project in projects:
		pi = '\t' * (project.indent - 1)
		print(pi + project.name + ':')
		tasks = project.get_tasks()
		for task in tasks:
			ti = '\t' * task.indent
		
			if task.checked:
				done_tag = ' @done'
			else:
				done_tag = ''
			print(pi + ('\t' * task.indent) + '- ' + task.content + done_tag)

def main(**kwargs):
    for key, value in kwargs.iteritems():
        print key, value

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Export Todoist data to taskpaper', version='%(prog)s 0.1')
    parser.add_argument('-o', '--out', type=str, default='todoist.taskpaper', help='name of output file')
    parser.add_argument('-c', '--completed', action='store_true', help='include completed tasks')
    parser.add_argument('-a', '--archived', action='store_true', help='include archived projects')
    args = parser.parse_args()
    main(**vars(args))