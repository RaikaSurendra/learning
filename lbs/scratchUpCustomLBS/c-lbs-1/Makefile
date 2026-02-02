# C Load Balancer Learning Project
# Main Makefile

CHAPTERS = chapter-01-fundamentals chapter-02-simple-proxy chapter-03-load-balancer chapter-04-advanced-features

.PHONY: all clean test $(CHAPTERS)

all: $(CHAPTERS)

$(CHAPTERS):
	@echo "Building $@..."
	@$(MAKE) -C $@ all

clean:
	@for dir in $(CHAPTERS); do \
		echo "Cleaning $$dir..."; \
		$(MAKE) -C $$dir clean; \
	done

# Quick test - build and run chapter 1 echo server
test-ch1:
	@$(MAKE) -C chapter-01-fundamentals all
	@echo "Starting echo server on port 8080..."
	@./chapter-01-fundamentals/echo_server 8080

# Quick test - run reverse proxy
test-ch2:
	@$(MAKE) -C chapter-01-fundamentals all
	@$(MAKE) -C chapter-02-simple-proxy all
	@echo "Starting backend on 9000 and proxy on 8080..."
	@./chapter-01-fundamentals/echo_server 9000 &
	@sleep 1
	@./chapter-02-simple-proxy/reverse_proxy 8080 127.0.0.1 9000

# Quick test - run load balancer
test-ch3:
	@$(MAKE) -C chapter-01-fundamentals all
	@$(MAKE) -C chapter-03-load-balancer all
	@echo "Starting 3 backends and load balancer..."
	@./chapter-01-fundamentals/echo_server 9001 &
	@./chapter-01-fundamentals/echo_server 9002 &
	@./chapter-01-fundamentals/echo_server 9003 &
	@sleep 1
	@./chapter-03-load-balancer/load_balancer 8080 127.0.0.1:9001 127.0.0.1:9002 127.0.0.1:9003

# Quick test - run advanced LB
test-ch4:
	@$(MAKE) -C chapter-01-fundamentals all
	@$(MAKE) -C chapter-04-advanced-features all
	@echo "Starting 3 weighted backends and advanced LB..."
	@./chapter-01-fundamentals/echo_server 9001 &
	@./chapter-01-fundamentals/echo_server 9002 &
	@./chapter-01-fundamentals/echo_server 9003 &
	@sleep 1
	@./chapter-04-advanced-features/advanced_lb 8080 127.0.0.1:9001:3 127.0.0.1:9002:2 127.0.0.1:9003:1

# Kill all test processes
stop:
	@pkill -f "echo_server" || true
	@pkill -f "reverse_proxy" || true
	@pkill -f "load_balancer" || true
	@pkill -f "advanced_lb" || true
	@echo "Stopped all processes"

help:
	@echo "C Load Balancer Learning Project"
	@echo "================================="
	@echo ""
	@echo "Build targets:"
	@echo "  make all        - Build all chapters"
	@echo "  make clean      - Clean all builds"
	@echo ""
	@echo "Test targets:"
	@echo "  make test-ch1   - Run Chapter 1 (echo server)"
	@echo "  make test-ch2   - Run Chapter 2 (reverse proxy)"
	@echo "  make test-ch3   - Run Chapter 3 (load balancer)"
	@echo "  make test-ch4   - Run Chapter 4 (advanced LB)"
	@echo "  make stop       - Kill all test processes"
	@echo ""
	@echo "In another terminal, test with:"
	@echo "  echo 'Hello' | nc localhost 8080"
	@echo "  curl http://localhost:8080/"
