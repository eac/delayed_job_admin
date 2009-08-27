require File.join(File.dirname(__FILE__), 'delayed_job_admin', 'administration')
Delayed::Job.__send__(:include, DelayedJobAdmin::Administration)