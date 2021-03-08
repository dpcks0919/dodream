package com.dodream.model;

public enum RequestType {
	STUFF {
		@Override
		public String toString() {
			return "Stuff";
		}
	}, 
	FINANCE {
		@Override
		public String toString() {
			return "Finance";
		}
	},
	SERVICE {
		@Override
		public String toString() {
			return "Service";
		}
	}, 
	ETC{
		@Override
		public String toString() {
			return "Etc";
		}
	}
}
