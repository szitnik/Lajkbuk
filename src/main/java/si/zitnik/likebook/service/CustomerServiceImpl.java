package si.zitnik.likebook.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import si.zitnik.likebook.domain.Customer;
import si.zitnik.likebook.repository.CustomerRepository;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/11/13
 * Time: 10:35 AM
 * To change this template use Customer | Settings | Customer Templates.
 */
@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {

    @PersistenceContext
    private EntityManager entityManager;

    @Resource
    private CustomerRepository customerRepository;

    @Transactional
    public void save(Customer customer) {
        if (customer.getId() == null) {
            entityManager.persist(customer);
        } else {
            entityManager.merge(customer);
        }
    }

    @Transactional
    public List<Customer> list() {
        List<Customer> customers = (List<Customer>)this.entityManager.createQuery("select c from Customer c").getResultList();
        return customers;
    }


    @Transactional
    public Customer get(Long id) {
        return customerRepository.findById(id);
    }


    @Transactional
    public void remove(Long id) {
        customerRepository.delete(id);
    }
}
